require 'test_helper'
require 'minitest/autorun'

describe 'bin/oui_lookup' do
  let(:binary) { 'bin/oui_lookup' }
  it 'should display usage with no arguments' do
    `#{binary}`.must_match /^Usage:/
  end
  it 'should return Sytek Inc.' do
    search = `#{binary} 000010`
    search.must_match /SYTEK INC\./
  end
  it 'should return not found' do
    search = `#{binary} FFFFFF 2>&1`
    search.must_match /\AOUI not found: FF-FF-FF/
  end
end # describe 'bin/oui_lookup'
