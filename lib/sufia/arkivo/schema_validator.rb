require 'json-schema'

module Sufia
  module Arkivo
    ITEM_SCHEMA = {
      type: 'object',
      required: [
        'token',
        'metadata',
        'file'
      ],
      properties: {
        metadata: {
          title: { required: true },
          creators: { required: true },
          tags: { required: true },
          rights: { required: true }
        },
        file: {
          base64: { required: true },
          md5: { required: true },
          filename: { required: true }
        }
      }
    }

    class InvalidItem < RuntimeError
    end

    class SchemaValidator
      attr_reader :item

      def initialize(item)
        @item = item
      end

      def run
        JSON::Validator.validate!(Sufia::Arkivo::ITEM_SCHEMA, item)
      rescue JSON::Schema::ValidationError => exception
        raise Sufia::Arkivo::InvalidItem.new(exception.message)
      end
    end
  end
end
