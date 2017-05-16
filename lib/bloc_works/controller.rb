require "erubis"
require "bloc_works/utility"

module BlocWorks
   class Controller
     attr_accessor :request

     def request
       @request ||= Rack::Request.new(@env)
     end

     def params
       request.params
     end

     def response(text, status = 200, headers = {})
        raise "Cannot respond multiple times" unless @response.nil?
        @response = Rack::Response.new([text].flatten, status, headers)
      end

  #  #2
      def render(*args)
        response(create_reponse_array(*args))
      end

  #  #3
      def get_response
        @response
      end

  #  #4
      def has_response?
        !@response.nil?
      end

     def create_reponse_array(view, locals = {})
       filename = File.join("app", "views", controller_dir, "#{view}.html.erb")
       template = File.read(filename)
       eruby = Erubis::Eruby.new(template)
       eruby.result(locals.merge(env: @env))
     end

     def controller_dir
      klass = self.class.to_s
      klass.slice!("Controller")
      BlocWorks.snake_case(klass)
    end

  end 
end
