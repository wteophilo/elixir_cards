defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  @sample_deck Cards.create_deck()
  @temp_filename "temp_deck_storage.bin"

  setup do
    on_exit(fn ->
      File.rm(@temp_filename)
    end)
    :ok
  end

  test "create_deck makes 20 cards"  do
    deck_lenght = length(@sample_deck)
    assert deck_lenght == 20
  end

  test "shuffling a deck randomizes it" do
    refute @sample_deck == Cards.shuffle(@sample_deck)
  end

  test "save deck into a file" do
    result = Cards.save(@sample_deck, @temp_filename)
    assert result == :ok
    assert File.exists?(@temp_filename)
  end

  test "load successfully reads and deserializes an existing file" do
    Cards.save(@sample_deck, @temp_filename)
    loaded_deck = Cards.load(@temp_filename)
    assert loaded_deck == @sample_deck
  end

  test "load returns the error message if the file does not exist" do
    result = Cards.load("non_existent_file.dat")
    assert result == "That file does not exist"
  end
end
