module Inquisition
  module Core
    module Partials
      module HtmlPartial
        def partial(name, locals)
          engine.new(template(name)).render(presenter(locals))
        end

        def partials_path
          File.join(Inquisition.root, template_path, 'partials')
        end

        private

        def presenter(locals)
          Core::Presenters::Pages::PartialPresenter.new(locals)
        end

        def engine
          Core::Outputers::HtmlOutputer::BASE_ENGINE
        end

        def template(name)
          File.join(partials_path, name)
        end

        def template_path
          Core::Outputers::HtmlOutputer::TEMPLATE_PATH
        end
      end
    end
  end
end
