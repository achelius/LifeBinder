
lb.frameConstructors = {
  AbilitiesList     = lb.controls.AbilitiesList,
  HorizontalIconsList    = lb.controls.HorizontalIconsList
}


UI.CreateLbFrame = function(type, name, parent)
  local constructor = lb.frameConstructors[type]
  if constructor then
    return constructor(name, parent)
  else
    return  UI.CreateFrame(type, name, parent)
  end
end
