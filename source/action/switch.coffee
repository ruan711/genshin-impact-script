state.isFiredSwitch = false
state.isPressedSwitch = false

# function

onSwitchEnd = (onSwitch) ->

  if onSwitch == 'e~'
    player.useE 'holding'
    return

  unless state.isPressedSwitch
    player.useE()
    return

  $.press 'e:up'
  skillTimer.record 'end'

# binding

player.on 'switch:start', (key) ->
  $.press key
  unless Scene.name == 'normal' then return
  party.switchTo key
  state.isFiredSwitch = false
  state.isPressedSwitch = false

player.on 'switch:end', ->

  unless Scene.name == 'normal' then return

  if state.isFiredSwitch
    {name} = party
    {onSwitch} = Character.data[name]
    onSwitchEnd onSwitch
    return
  state.isFiredSwitch = true

party.on 'switch', ->

  unless Scene.name == 'normal' then return

  {name} = party
  unless name then return

  {onSwitch} = Character.data[name]
  unless onSwitch then return

  if state.isFiredSwitch
    onSwitchEnd onSwitch
    return
  state.isFiredSwitch = true

  unless onSwitch == 'e' then return

  state.isPressedSwitch = true
  $.press 'e:down'
  skillTimer.record 'start'