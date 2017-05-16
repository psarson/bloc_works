require "bloc_works/version"

module BlocWorks
  class Application
     def call(env)
       if env['PATH_INFO'] == '/favicon.ico'
         return [404, {'Content-Type' => 'text/html'}, []]
       end

       klass, action = controller_and_action(env)
       controller = klass.new(env)
       text = controller.send(action)

       if controller.has_response?
         status, header, response = controller.get_response
         [status, header, [response.body].flatten]
       else
         [200, {'Content-Type' => 'text/html'}, [text]]
       end

    end
  end
end
