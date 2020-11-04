require 'rails_helper'

describe RecipesHelper do
  describe '#render_description' do
    let(:string) { "*test*" }

    it { expect(helper.render_description(string)).to eq("<p><em>test</em></p>\n") }

    context 'string is nil' do
      let(:string) { nil }

      it { expect(helper.render_description(string)).to eq('') }
    end
  end
end
