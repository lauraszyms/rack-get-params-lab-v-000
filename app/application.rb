class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end


    if @@cart.empty?
      resp.write "Your cart is empty!"
    elsif req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "Your cart contains #{@@cart.join("\n")}"
      end
    end
    if  req.path.match(/add/)
      item_to_add = req.params["item"]
      resp.write add_item(item_to_add)
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_item(item_to_add)
    if @@items.include?(item_to_add)
      @@cart << item_to_add
      return "added #{item_to_add}"
    else
      return "We don't have that item"
    end
  end





end
