require "bloc_works/version"
require "bloc_works/router"
require "bloc_works/utility"
require "bloc_works/dependencies"
require "bloc_works/controller"

module BlocWorks
  class Application
     def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      klass, action = controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(action)
      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end
end
