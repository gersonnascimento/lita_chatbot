module Lita
  module Handlers
    class Teste < Handler
      route(/tudo bem\?/, :resp_tudo_bem)
      route(/seu nome\?/, :resp_nome)

      route(/marcas/, :marcas) #teste com api da tabela fipe


      def resp_tudo_bem(response)
        response.reply('Tudo ótimo, e você?')
      end

      def resp_nome(response)
        response.reply('Eu sou o Oscar.')
      end

      def marcas(response)
        http_response = http.get('https://api.mercadolibre.com/sites/MLA/categoriesk')
        parsed = MultiJson.load(http_response.body)

        resp = parsed.map{|x| x['name']}.join(',')

        response.reply(resp)
      end

      Lita.register_handler(self)
    end
  end
end
