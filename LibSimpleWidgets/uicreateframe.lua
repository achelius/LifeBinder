local frameConstructors = {
  SimpleCheckbox    = Library.LibSimpleWidgets.Checkbox,
  SimpleList        = Library.LibSimpleWidgets.List,
  SimpleRadioButton = Library.LibSimpleWidgets.RadioButton,
  SimpleScrollView  = Library.LibSimpleWidgets.ScrollView,
  SimpleSelect      = Library.LibSimpleWidgets.Select,
  SimpleSlider      = Library.LibSimpleWidgets.Slider,
  SimpleTabView     = Library.LibSimpleWidgets.TabView,
  SimpleTextArea    = Library.LibSimpleWidgets.TextArea,
  SimpleTooltip     = Library.LibSimpleWidgets.Tooltip,
  SimpleWindow      = Library.LibSimpleWidgets.Window,
}

local oldUICreateFrame = UI.CreateFrame
UI.CreateFrame = function(type, name, parent)
  local constructor = frameConstructors[type]
  if constructor then
    return constructor(name, parent)
  else
    return oldUICreateFrame(type, name, parent)
  end
end
