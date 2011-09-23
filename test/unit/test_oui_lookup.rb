require 'test_helper'
require 'minitest/autorun'

describe OUI_Lookup::Lookup do
  it 'should use a valid URI prefix' do
    OUI_Lookup::Lookup::URL.must_match %r{^http://}
  end
  
  describe '#new' do
    let(:prefix) { '00-00-00' }
    let(:mac_address) { '11-22-33-44-55-66' }
    it 'should accept three conjoined octets' do
      OUI_Lookup::Lookup.new('000000').oui.must_equal prefix
    end
    it 'should accept three colon-separated octets' do
      OUI_Lookup::Lookup.new('00:00:00').oui.must_equal prefix
    end
    it 'should accept three dash-separated octets' do
      OUI_Lookup::Lookup.new('00-00-00').oui.must_equal prefix
    end
    it 'should accept six octets' do
      OUI_Lookup::Lookup.new('112233445566').oui.must_equal '11-22-33'
    end
    it 'should raise error with too few octets' do
      lambda {OUI_Lookup::Lookup.new '1122'}.must_raise ArgumentError
    end
    it 'should raise error with too many octets' do
      lambda {OUI_Lookup::Lookup.new '11223344556677'}.must_raise ArgumentError
    end
  end # describe #new
end # describe OUI_Lookup::Lookup
