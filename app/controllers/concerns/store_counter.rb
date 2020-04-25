module StoreCounter

  def reset_counter
    session[:counter] = 0
  end

  private
    def count_hits
      if session[:counter].nil?
        session[:counter] = 0
      end
      session[:counter] = session[:counter] + 1;
    end
    
end