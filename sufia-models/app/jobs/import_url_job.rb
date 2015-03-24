require 'net/https'
require 'uri'
require 'tempfile'

class ImportUrlJob < ActiveFedoraPidBasedJob

  def queue_name
    :import_url
  end

  def run
    user = User.find_by_user_key(generic_file.depositor)
    uri = Addressable::URI.parse(generic_file.import_url)

    spec = {
      "url" => uri.display_uri,
      "file_size" => 0,
    }

    # Get the MIME types from the file name if there is no
    # header
    mime_types = MIME::Types.of(uri.basename)
    mime_type = mime_types.empty? ? "application/octet-stream" : mime_types.first.content_type

    Tempfile.open(pid.gsub('/', '_')) do |f|
      retriever = BrowseEverything::Retriever.new
      retriever.download(spec, f)

      # attach downloaded file to generic file stubbed out
      if Sufia::GenericFile::Actor.new(generic_file, user).create_content(f, uri.basename, 'content', mime_type)
        # add message to user for downloaded file
        message = "The file (#{generic_file.label}) was successfully imported."
        job_user.send_message(user, message, 'File Import')
      else
        job_user.send_message(user, generic_file.errors.full_messages.join(', '), 'File Import Error')
      end
    end
  end

  def copy_remote_file(import_url, f)
    f.binmode
    # download file from url
    uri = URI(generic_file.import_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"  # enable SSL/TLS
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    mime_type = nil

    http.start do
      http.request_get(uri.request_uri) do |resp|
        mime_type = resp.content_type
        resp.read_body do |segment|
          f.write(segment)
        end
      end
    end

    f.rewind
    return uri.path, mime_type
  end

  def job_user
    User.batchuser
  end
end
