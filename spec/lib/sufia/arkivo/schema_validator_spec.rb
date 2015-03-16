require 'spec_helper'

describe Sufia::Arkivo::SchemaValidator do
  it 'ensures a token is included'
  it 'ensures a metadata section is included'
  it 'ensures a file section is included'
  it 'ensures the metadata has a title'
  it 'ensures the metadata has creators'
  it 'ensures the metadata has tags'
  it 'ensures the metadata has rights'
  it 'ensures the file has a b64-encoded content'
  it 'ensures the file has a checksum'
  it 'ensures the file has a filename'
  it 'raises InvalidItem is the item is invalid'
end
