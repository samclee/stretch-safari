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
  nextobjectid = 6,
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
          id = 3,
          name = "giraffe",
          type = "VisibleSubject",
          shape = "rectangle",
          x = 575.433,
          y = 301.989,
          width = 100,
          height = 300,
          rotation = 0,
          visible = true,
          properties = {
            ["idle_spr"] = "giraffe",
            ["notice_spr"] = "giraffe2"
          }
        },
        {
          id = 4,
          name = "dog",
          type = "VisibleSubject",
          shape = "rectangle",
          x = 52.4688,
          y = 424.926,
          width = 300,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["idle_spr"] = "dog",
            ["notice_spr"] = "dog2"
          }
        },
        {
          id = 5,
          name = "snake",
          type = "VisibleSubject",
          shape = "rectangle",
          x = 160.738,
          y = 91.7609,
          width = 200,
          height = 250,
          rotation = 0,
          visible = true,
          properties = {
            ["idle_spr"] = "snake",
            ["notice_spr"] = "snake2"
          }
        }
      }
    }
  }
}
