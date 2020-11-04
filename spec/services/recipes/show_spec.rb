require 'rails_helper'

describe Recipes::Show do
  describe '#call' do
    let(:id) { 'id' }

    subject(:service) { described_class.new(id: id) }

    let(:contentful_stub) { double() }

    before do
      allow(Contentful::Client).
        to receive(:new).
          and_return(contentful_stub)

      allow(contentful_stub).
        to receive(:entry).
          with(id, content_type: Recipes::RECIPE_CONTENT_TYPE).
          and_return(contentful_result)
    end

    context 'success response from contenful' do
      let(:contentful_result) do
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
      end

      let(:service_call) { service.call }

      it { expect(service_call.id).to eq('rec1') }
      it { expect(service_call.title).to eq('Rec1') }
      it { expect(service_call.description).to eq('description') }
      it { expect(service_call.image_url).to eq('url') }
      it { expect(service_call.tags.first.id).to eq('tag1') }
      it { expect(service_call.tags.first.name).to eq('Tag1') }
      it { expect(service_call.chef.id).to eq('chef1') }
      it { expect(service_call.chef.name).to eq('Chef1') }
    end

    context 'invalid id' do
    end
  end
end
