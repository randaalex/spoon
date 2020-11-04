require 'rails_helper'

describe Recipes::Index do
  describe '#call' do
    subject(:service) { described_class.new(page: page) }

    let(:contentful_stub) { double() }
    let(:contentful_result) { double() }

    before do
      allow(Contentful::Client).
        to receive(:new).
          and_return(contentful_stub)


      allow(contentful_stub).
        to receive(:entries).
          with(
            content_type: Recipes::RECIPE_CONTENT_TYPE,
            limit: Recipes::Index::PER_PAGE,
            skip: skip,
          ).
          and_return(contentful_result)

      allow(contentful_result).
        to receive(:items).
          and_return(contentful_items)

      allow(contentful_result).
        to receive(:total).
          and_return(4)
    end

    context 'success response from contenful' do
      let(:contentful_items) do
        [
          OpenStruct.new(
            id: 'rec1',
            title: 'Rec1',
            photo: OpenStruct.new(url: 'url'),
            description: 'description',
            chef: OpenStruct.new(id: 'chef1', name: 'Chef1'),
            tags: [
              OpenStruct.new(id: 'tag1', name: 'Tag1')
            ]
          )
        ]
      end

      let(:service_call) { service.call }

      context 'page is nil' do
        let(:page) { nil }
        let(:skip) { 0 }

        it { expect(service_call[:pages_total]).to eq(4) }
        it { expect(service_call[:pages_count]).to eq(2) }
        it { expect(service_call[:data]).to be_instance_of(Array) }
        it { expect(service_call[:data].first.id).to eq('rec1') }
        it { expect(service_call[:data].first.image_url).to eq('url') }
        it { expect(service_call[:data].first.tags.first.id).to eq('tag1') }
        it { expect(service_call[:data].first.chef.id).to eq('chef1') }
      end

      context 'page is 1' do
        let(:page) { 1 }
        let(:skip) { 0 }

        it { expect(service_call[:pages_total]).to eq(4) }
        it { expect(service_call[:pages_count]).to eq(2) }
        it { expect(service_call[:data]).to be_instance_of(Array) }
      end

      context 'page is out' do
        let(:page) { 99 }
        let(:skip) { 294 }

        it { expect(service_call[:pages_total]).to eq(4) }
        it { expect(service_call[:pages_count]).to eq(2) }
        it { expect(service_call[:data]).to be_instance_of(Array) }
      end
    end
  end
end
