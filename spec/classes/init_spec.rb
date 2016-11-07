require 'spec_helper'
describe 'hub_keys' do

  context 'with defaults for all parameters' do
    it { should contain_class('hub_keys') }
  end
end
