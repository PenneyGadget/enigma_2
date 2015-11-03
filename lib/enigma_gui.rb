require_relative 'enigma'

Shoes.app {
  background "#606A75".."#130652"
  border("#0E067A", strokewidth: 6)
  @intro = stack(margin: 100) do
    para strong("If you give me a message, I will encrypt it for you!")
    @e = edit_line :width => 400, :height => 200
    button "Encrypt!" do
      alert @e.text
    end
  end
}
