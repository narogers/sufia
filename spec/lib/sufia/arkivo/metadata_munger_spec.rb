require 'spec_helper'

describe Sufia::Arkivo::MetadataMunger do
  it 'takes this metadata and produces this other metadata'
  it 'makes camelCase symbols into underscored strings'
  it 'replaces url with related_url'
  it 'replaces tags with tag'
  it 'replaces firstName and lastName with name'
  it 'segregates creators and contributors'
  it 'deletes the original creators array'
end
