require 'spec_helper'

describe Sufia::Arkivo::Actor do
  it 'monkey-patches Tempfile'

  describe '#create_file_from_item' do
    it 'tests the impl'
    it 'stores a checksum'
    it 'extracts a file from the item'
  end

  describe '#update_file_from_item' do
    it 'tests the impl'
    it 'resets the metadata'
    it 'stores a checksum'
    it 'extracts a file from the item'
  end

  describe '#destroy_file' do
    it 'tests the impl'
  end
end
