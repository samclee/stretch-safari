return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 9,
  height = 7,
  tilewidth = 100,
  tileheight = 100,
  nextlayerid = 3,
  nextobjectid = 4,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 9,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      id = 2,
      name = "myobjects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "stretch",
          type = "Subject",
          shape = "rectangle",
          x = 100,
          y = 200,
          width = 300,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "safari",
          type = "Subject",
          shape = "rectangle",
          x = 600,
          y = 100,
          width = 100,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "star",
          type = "Subject",
          shape = "rectangle",
          x = 700,
          y = 500,
          width = 100,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
