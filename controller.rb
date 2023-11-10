class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Pegar todas as recipes do cookbook
    recipes = @cookbook.all
    # 2. Passar as recipes para a View listar
    @view.display_list(recipes)
  end

  def add
    # 1. Perguntar ao usuário o nome da receita
    name = @view.ask_name

    # 2. Perguntar a descrição da receita
    description = @view.ask_description

    # 3. Instanciar uma nova receita
    new_recipe = Recipe.new(name, description)

    # 4. Adicionar a receita ao cookbook
    @cookbook.create(new_recipe)
  end

  def remove
    # 1. Mostrar todas as receitas
    list

    # 2. Perguntar o index da receita a ser removida
    index = @view.ask_index

    # 3. excluir do cookbook
    @cookbook.destroy(index)
  end

  def import
    # 1. Perguntar qual o ingrediente
    ingredient = @view.ask_ingredient

    # 2. Listar as 5 primeiras receitas do ingrediente
    url = "https://www.allrecipes.com/search?q=#{ingredient}"
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")

    # 3. listar e perguntar qual o index da receita para importar
    links = []
    doc.search('a.mntl-card-list-items').first(5).each_with_index do |link, index|
      puts "#{index + 1} - #{link.search('.card__title-text').text}"
      links << link.attributes['href'].value
    end

    index = @view.ask_index

    # 4. Obter os dados da receita selecionada
    url = links[index]
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")

    name = doc.search('h1').text
    description = doc.search('#article-subheading_1-0').text.strip

    # 5. Instaciar uma nova receita
    new_recipe = Recipe.new(name, description)

    # 6. Adicionar a nova receita ao cookbook
    @cookbook.create(new_recipe)
  end
end
