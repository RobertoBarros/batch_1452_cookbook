class View

  def ask_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_description
    puts "Enter recipe description:"
    gets.chomp
  end

  def ask_index
    puts "Enter recipe index:"
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "Enter ingredient to search:"
    gets.chomp
  end

  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}: #{recipe.description}"
    end
  end
end
