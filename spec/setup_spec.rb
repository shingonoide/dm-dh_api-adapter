require 'dm-core/spec/setup'
require 'dm-dh_api-adapter/models'

describe DataMapper do
  describe '.setup' do
    describe 'using connection string' do
      before :all do
        @return = DataMapper.setup(:setup_test, 'dh_api:///?api_key=6SHU5P2HLDAYECUM&foo=bar&baz=foo#fragment')

        @options = @return.options
      end

      after :all do
        DataMapper::Repository.adapters.delete(@return.name)
      end

      it 'should return an Adapter DhApi' do
        @return.should be_kind_of(DataMapper::Adapters::DhApiAdapter)
      end

      it 'should set up the repository' do
        DataMapper.repository(:setup_test).adapter.should equal(@return)
      end

      {
        :adapter => 'dh_api',
        :query => 'api_key=6SHU5P2HLDAYECUM&foo=bar&baz=foo'
      }.each do |key, val|
        it "should extract the #{key.inspect} option from the uri" do
          @options[key].should == val
        end
      end

      it 'should alias the scheme of the uri as the adapter' do
        @options[:scheme].should == @options[:adapter]
      end

      it 'should leave the query param intact' do
        @options[:query].should == 'api_key=6SHU5P2HLDAYECUM&foo=bar&baz=foo'
      end

      it 'should extract the query param as top-level options' do
        @options[:api_key].should == '6SHU5P2HLDAYECUM'
      end
    end

    describe 'using options' do
      before :all do
        @return = DataMapper.setup(:setup_test, :adapter => :dh_api, :api_key => '6SHU5P2HLDAYECUM')

        @options = @return.options
      end

      after :all do
        DataMapper::Repository.adapters.delete(@return.name)
      end

      it 'should return an Adapter' do
        @return.should be_kind_of(DataMapper::Adapters::DhApiAdapter)
      end

      it 'should set up the repository' do
        DataMapper.repository(:setup_test).adapter.should equal(@return)
      end

      {
          :adapter => :dh_api,
          :api_key => '6SHU5P2HLDAYECUM'
      }.each do |key, val|
        it "should set the #{key.inspect} option" do
          @options[key].should == val
        end
      end
    end

    describe 'using invalid options' do
      it 'should raise an exception' do
        lambda {
          DataMapper.setup(:setup_test, :invalid)
        }.should raise_error(ArgumentError, '+options+ should be Hash or Addressable::URI or String, but was Symbol')
      end
    end

    describe 'using an instance of an adapter' do
      before :all do
        @adapter = DataMapper::Adapters::DhApiAdapter.new(:setup_test)

        @return = DataMapper.setup(@adapter)
      end

      after :all do
        DataMapper::Repository.adapters.delete(@return.name)
      end

      it 'should return an Adapter' do
        @return.should be_kind_of(DataMapper::Adapters::DhApiAdapter)
      end

      it 'should set up the repository' do
        DataMapper.repository(:setup_test).adapter.should equal(@return)
      end

      it 'should use the adapter given' do
        @return.should == @adapter
      end

      it 'should use the name given to the adapter' do
        @return.name.should == @adapter.name
      end
    end
  end
end

describe "Dh_Api adapter builtin " do

  before :all do
    @return = DataMapper.setup(:default, :adapter => :dh_api, :api_key => '6SHU5P2HLDAYECUM')

    @options = @return.options
  end

  after :all do
    DataMapper::Repository.adapters.delete(@return.name)
  end

  describe "Model for Domain" do

    it "should first record exists" do
      DataMapper::DhApi::Models::Domain.first.should be
    end

    it "should first.domain record be 718apts.com" do
      DataMapper::DhApi::Models::Domain.first.domain.should == '718apts.com'
    end

    it "should last.domain record be 718apts.com" do
      DataMapper::DhApi::Models::Domain.last.domain.should == '718apts.com'
    end

    it "should get Domain.all records and count 14 domains" do
      domains = DataMapper::DhApi::Models::Domain.all
      domains.count.should be(14)
    end

  end

  describe "Model for DNS" do

    it "should first record exists" do
      DataMapper::DhApi::Models::DNS.first.should be
    end

    it "should first.record be 718apts.com" do
      DataMapper::DhApi::Models::DNS.first.record.should == '718apts.com'
    end

    it "should last.record be 718apts.com" do
      DataMapper::DhApi::Models::DNS.last.record.should == '718apts.com'
    end

    it "should get all and count 202 records" do
      DataMapper::DhApi::Models::DNS.all.count.should be(202)
    end

  end



end

describe 'DataMapper::Adapters::DhApiAdapter' do

  before :all do
    @return = DataMapper.setup(:default, :adapter => :dh_api, :api_key => '6SHU5P2HLDAYECUM')

    @options = @return.options
    @repository = DataMapper.repository(@return.name)
  end


end
