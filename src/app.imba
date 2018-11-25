let emoji = ["🐀","🐁","🐂","😃","😄","😅","😆","😇","😈","😉","😊","😋","😌","😍","😎","😏","🤐","🤑","🤒","🤓","🤔","🤕","🤖","🤗","🤘","🤙","🤚","🤛","🤜","🤝","🤞","🌟","🐠","🌡","🐢","🐣","🌤","🌥","🌦","🌧","🌨","🌩","🌪","😫","😬","😭","😮","😯","😰","😱","🐲","🐳","🐴","🐵","🐶","🐷","🐸","🐹","🐺","🐻","🐼","🐽","🌾","🌿","🍀","🍁","🍂","🍃","🍄","🍅","🍆","🍇","🍈","🍉","🍊","🍋","🍌","🍍","🍎","🍏","🥐","🥑","🍒","🍓","🍔","🍕","🍖","🍗","🍘","🍙","🍚","🍛","🍜","🍝","🍞","🍟","🍠","🍡","🍢","🍣","🍤","🍥","🍦","🍧","🍨","🍩","🍪","🍫","🍬","🍭","🍮","🍯","🍰","🍱","🍲","🍳","🍴","🍵","🍶","🍷","🍸","🍹","🍺","🍻","🍼","🍽","🍾","🍿","🎀","🎁","🎂","🎃","🎄","🎅","🦆","💇","🦈","🦉","🦊","🦋","🦌","🦍","🦎","💏","💐","💑","💒","💓","💔","💕","🎖","🎗","💘","🚙","🚚","🚛","🚜","🚝","🚞","🚟","🚠","🚡","🚢","🚣","🚤","💥","🚦","🚧","🚨","🎩","🎪","🎫","🎬","🎭","🎮","🎯","🎰","🎱","🎲","🎳","🎴","🎵","🎶","🎷","🎸","🎹","🎺","🎻","🎼","🎽","🎾","🎿","🏀","🏁","🏂","🏃","🏄","🏅","🏆","🏇","🏈","🏉","🏊","🏋","🏌","🏍","🏎","🃏","🏐","🏑","🏒","🏓","🏔","🏕","🏖","🏗","🏘","🏙","🏚","🏛","🏜","🏝","🗞","📟","🛠","🛡","🛢","🛣","🛤","🛥","🏦","🏧","🏨","🏩","🏪","🏫","🏬","🏭","🏮","🏯","🏰","📱","📲","🏳","🏴","🏵","📶","🏷","🏸","🏹","🏺","📻","📼","📽","🗾","📿"]

let def shuffle(a)
  let i = a:length - 1
  while i > 0
    let j = Math.floor(Math.random() * (i + 1))
    a[i], a[j] = a[j], a[i]
    i -= 1
  a

let def new_game(size)
  let result = []
  while result:length < size
    let j = Math.floor(Math.random() * emoji:length)
    let e = emoji[j]
    unless result.includes(e)
      result.push(e)

  shuffle([*result, *result]).map do |e|
    { emoji: e, state: "hidden" }

tag Tile
  def onclick
    return unless data:state == "hidden"
    trigger('tile', data)

  def render
    <self.tile .hidden=(data:state == "hidden")>
      if data:state == "hidden"
        " "
      else
        data:emoji

tag Game
  def game_won
    data:tiles.every do |e|
      e:state == "known"

  def ontile(event, tile)
    if data:first == null
      data:first = tile
      tile:state = "first"
    else if data:second == null
      if data:first:emoji == tile:emoji
        data:first:state = "known"
        tile:state = "known"
        data:first = null
        if game_won
          trigger('won')
      else
        data:second = tile
        tile:state = "second"
    else
      data:first:state = "hidden"
      data:second:state = "hidden"
      data:first = tile
      data:second = null
      tile:state = "first"

  def render
    <self.game.{"size-{data:size}"}>
      for tile in data:tiles
        <Tile[tile]>

tag App
  def setup
    @playing = false

  def onwon
    @playing = false

  def start(size)
    let tiles = new_game(size * size / 2)
    @game = { tiles: tiles, first: null, second: null, size: size }
    @playing = true

  def render
    <self>
      <header>
        "Memory game"
      if @game
        <Game[@game]>
      unless @playing
        <div.button_bar>
          <div>
            "Start game:"
          <div>
            <button :click=(do start(2))>
              "2x2"
            <button :click=(do start(4))>
              "4x4"
            <button :click=(do start(6))>
              "6x6"

Imba.mount <App>
