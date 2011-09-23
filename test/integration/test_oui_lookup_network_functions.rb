require 'test_helper'
require 'resolv'
require 'minitest/autorun'

describe 'OUI_Lookup network integration' do
  let(:url) { OUI_Lookup::Lookup::URL }
  it 'should use a resolvable hostname for lookups' do
    hostname = url.split('/')[2]
    Resolv.getaddress(hostname).
      must_match /(\d{1,3}.){3}\d{1,3}/
  end
  it 'should successfully returns a web page' do
    RestClient.head(url).code.must_equal 200
  end
end # describe 'OUI_Lookup network integration'

describe 'sample lookups' do
  let(:silent) { true }
  it 'should return Xerox' do
    OUI_Lookup::Lookup.new('000000', silent).run.must_match /Xerox/i
  end
  it 'should return Infinite Shanghai Communication Terminals Ltd.' do
    OUI_Lookup::Lookup.new('000510', silent).run.
      must_match /Infinite Shanghai Communication Terminals Ltd\./
  end
end # describe 'sample lookups'
