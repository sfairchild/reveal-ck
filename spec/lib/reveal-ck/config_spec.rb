require 'spec_helper'

module RevealCK
  describe Config do

    class Example
      include Config
    end

    context 'when included in a class' do

      it 'supplies an #theme, and #theme=' do
        example = Example.new
        example.theme = 'night'
        expect(example.theme).to eq 'night'
      end

      it 'supplies a default theme' do
        example = Example.new
        expect(example.theme).to eq 'default'
      end

      it 'supplies an #author, and #author=' do
        example = Example.new
        example.author = 'Jed Northridge'
        expect(example.author).to eq 'Jed Northridge'
      end

      it 'supplies a default author' do
        example = Example.new
        expect(example.author).to eq ''
      end

      it 'supplies an #title, and #title=' do
        example = Example.new
        example.title = 'My Presentation'
        expect(example.title).to eq 'My Presentation'
      end

      it 'supplies a default title' do
        example = Example.new
        expect(example.title).to eq 'Slides'
      end

      it 'supplies an #transition, and #transition=' do
        example = Example.new
        example.transition = 'page'
        expect(example.transition).to eq 'page'
      end

      it 'supplies a default transition' do
        example = Example.new
        expect(example.transition).to eq 'default'
      end

    end

    describe '#from_file' do
      it 'can read in settings from a .yml' do
        example = Example.new
        example.from_file(file: spec_data('config', 'full_config.yml'))
        expect(example.title).to eq 'The Never Sea Slides'
        expect(example.author).to eq 'Captain Hook'
        expect(example.theme).to eq 'night'
        expect(example.transition).to eq 'page'
      end
    end

    describe '#merge' do

      let :full_config do
        example = Example.new
        example.title = 'The Never Sea Slides'
        example.author = 'Captain Hook'
        example.theme = 'night'
        example.transition = 'page'
        example
      end

      let :partial_config do
        example = Example.new
        example.title = 'The Never Sea Slides'
        example
      end

      it 'merges unset config options' do
        example = Example.new
        example.merge(full_config)
        expect(example.title).to eq 'The Never Sea Slides'
        expect(example.author).to eq 'Captain Hook'
        expect(example.theme).to eq 'night'
        expect(example.transition).to eq 'page'
      end

      it 'can grab just a single option' do
        example = Example.new
        example.merge(partial_config)
        expect(example.title).to eq 'The Never Sea Slides'
      end

      it 'will overwrite already set config options' do
        example = Example.new
        example.author = 'Jed Northridge'
        example.transition = 'fade'
        example.merge(full_config)
        expect(example.author).to eq 'Captain Hook'
        expect(example.transition).to eq 'page'
        expect(example.title).to eq 'The Never Sea Slides'
        expect(example.theme).to eq 'night'
      end

      it 'will not overwrite set config options with defaults' do
        example = Example.new
        example.author = 'Jed Northridge'
        example.merge(partial_config)
        expect(example.author).to eq 'Jed Northridge'
      end
    end
  end
end
