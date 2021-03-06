alias SaborBrasileiro.{Repo, User}
alias Ecto.Changeset

user_admin_params = %{
  "name" => "Crispim Borges",
  "surname" => "De Meneses",
  "email" => "crispimborges@gmail.com",
  "password" => "123456",
  "nickname" => "crispimborges",
  "avatar" => %{
    "url" =>
      "https://scontent.fcgh37-1.fna.fbcdn.net/v/t1.6435-9/75588105_10212710874201644_8796001797102632960_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=AO5XpWOWO0MAX9mq9k3&_nc_ht=scontent.fcgh37-1.fna&oh=460ecae06da142dc792108ef4ed03740&oe=6122D61F"
  }
}

# First User admin
{:ok, %User{} = user_admin} =
  user_admin_params
  |> SaborBrasileiro.create_user()

user_admin
|> Changeset.change(%{isAdmin: true, isConfectioner: true, isBestConfectioner: true})
|> Repo.update!()

# Inner Best Confectioners
best_confectioners = [
  %{
    "name" => "Caio Vinicius",
    "surname" => "Silva",
    "email" => "caiovinicius@gmail.com",
    "password" => "123456",
    "nickname" => "caiovinicius",
    "avatar" => %{
      "url" =>
        "https://scontent.fcgh37-1.fna.fbcdn.net/v/t1.6435-9/172648596_2900694813553215_2345534949071454827_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=w9B0vqzLFOcAX96AR_a&_nc_oc=AQktMD9IafvJgXVwicguZyoR27Ju4o0Xh7lHoLttvkumxek4PL9bNtx0ZPy87CcMXV6_7gzIi5aCedJpavwmj1QW&_nc_ht=scontent.fcgh37-1.fna&oh=3749c8a40dfab82bd8a0e90aa70adba7&oe=61234EC0"
    }
  },
  %{
    "name" => "Luis Gustavo",
    "surname" => "Borges Lemos",
    "email" => "luisgustavo@gmail.com",
    "password" => "123456",
    "nickname" => "luisgustavo",
    "avatar" => %{
      "url" =>
        "https://scontent.fcgh37-1.fna.fbcdn.net/v/t1.6435-9/120369887_3281992485219714_2822873302078033743_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=CjtpjfynwtoAX_kW3oI&tn=zohrAkJGksAUQ1xA&_nc_ht=scontent.fcgh37-1.fna&oh=bdbf81fd700b92277cf6377f723657fc&oe=6121EE3D"
    }
  },
  %{
    "name" => "Ester Meneses",
    "surname" => "Lemos",
    "email" => "estermeneses@gmail.com",
    "password" => "123456",
    "nickname" => "estermeneses",
    "avatar" => %{
      "url" =>
        "https://scontent.fcgh37-1.fna.fbcdn.net/v/t1.6435-9/54257647_2280570798846495_3667758807854874624_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=8bfeb9&_nc_ohc=rmTdAbZ5M1YAX8UrmeE&_nc_ht=scontent.fcgh37-1.fna&oh=2a7a9c55a9976208fcbb4151da2aeb64&oe=612344C0"
    }
  }
]

best_confectioners
|> Enum.map(fn best_confectioner ->
  {:ok, %User{} = user} = best_confectioner |> SaborBrasileiro.create_user()

  user
  |> Changeset.change(%{isConfectioner: true, isBestConfectioner: true})
  |> Repo.update!()
end)

# Cake categories
cake_categories_params = [
  %{
    "name" => "Bolos Recheados"
  },
  %{
    "name" => "Bolos com Cobertura"
  },
  %{
    "name" => "Bolos Caseiros"
  },
  %{
    "name" => "Bolos no pote"
  },
  %{
    "name" => "Coberturas"
  }
]

cake_categories_params
|> Enum.map(fn cake_category_params ->
  SaborBrasileiro.create_cake_category(cake_category_params)
end)

# Cakes
cakes_params = [
  %{
    "category" => "Bolos com Cobertura",
    "description" =>
      "Cont??m Gl??tem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em p?? integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "??leo"
      },
      %{
        "name" => "Iorgute natural integral"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Nutella"
      },
      %{
        "name" => "fermento."
      }
    ],
    "kg" => "1000kg",
    "name" => "Leite Ninho Cobertura Nutella",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202106261522_5V3B_i.jpg"
      }
    ],
    "price" => "45.00"
  },
  %{
    "category" => "Bolos com Cobertura",
    "description" =>
      "Cont??m Gl??tem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em p?? integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Muita Ganache"
      },
      %{
        "name" => "fermento."
      },
      %{
        "name" => "??leo"
      }
    ],
    "kg" => "1000kg",
    "name" => "Bolo Ninho Cobertura Ganache",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171921_R7KE_f.png"
      }
    ],
    "price" => "40.00"
  },
  %{
    "category" => "Bolos com Cobertura",
    "description" =>
      "Cont??m Gl??tem e lactose, Bolo Ninho coberto com brigadeiro ??timo para sobremesa, feito com chocolate 32%, leite condensado, margarina e creme de leite.",
    "ingredients" => [
      %{
        "name" => "leite condensado"
      },
      %{
        "name" => "margarina"
      },
      %{
        "name" => "creme de leite"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "fermento."
      }
    ],
    "kg" => "900kg",
    "name" => "Ninho Cobertura Brigadeiro",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171912_PWzW_f.png"
      }
    ],
    "price" => "38.00"
  },
  %{
    "category" => "Bolos Recheados",
    "description" =>
      "Bolo leite ninho ??timo para comer como sobremesa, Cobertura leite Ninho, com miolo recheado com Nutella e morangos. Cobertura feita com leite Ninho integral em p??, creme de leite, margarina sem sal e leite condensado.",
    "ingredients" => [
      %{
        "name" => "margarina"
      },
      %{
        "name" => "Morangos"
      },
      %{
        "name" => "Nutella"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "fermento."
      },
      %{
        "name" => "leite condensado"
      },
      %{
        "name" => "creme de leite"
      }
    ],
    "kg" => "1300kg",
    "name" => "Vulc??o Leite Ninho com Abacaxi",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171925_2v3V_f.png"
      }
    ],
    "price" => "78.00"
  },
  %{
    "category" => "Bolos Recheados",
    "description" =>
      "Bolo leite ninho ??timo para comer como sobremesa, Recheio de Ovomaltine, coberto com leite Ninho Contem Leite integral, farinha de trigo enriquecida com ferro e ??cido f??lico, a????car, ovo, chocolate em p??, fermentos qu??micos pirofosfato de s??dio, bicarbonato de s??dio e fosfato. Cont??m Gl??ten E Lactose.",
    "ingredients" => [
      %{
        "name" => "fermento."
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "chocolate garoto"
      },
      %{
        "name" => "Ganache"
      },
      %{
        "name" => "Ovo maltine"
      },
      %{
        "name" => "chocolate em p??"
      },
      %{
        "name" => "creme de leite"
      },
      %{
        "name" => "margarina"
      },
      %{
        "name" => "leite condensado"
      }
    ],
    "kg" => "900kg",
    "name" => "Vulc??o De Ovomaltine Coberto Com Ninho",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102181938_A0Nf_f.png"
      }
    ],
    "price" => "58.00"
  },
  %{
    "category" => "Bolos Recheados",
    "description" =>
      "Bolo leite ninho ??timo para comer como sobremesa, Cobertura leite Ninho, com miolo recheado com Nutella. Cobertura feita com leite Ninho integral, creme de leite, margarina sem sal e leite condensado.",
    "ingredients" => [
      %{
        "name" => "gordura vegetal"
      },
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "fermento."
      },
      %{
        "name" => "leite condensado"
      },
      %{
        "name" => "margarina"
      },
      %{
        "name" => "creme de leite"
      },
      %{
        "name" => "chocolate em p??"
      },
      %{
        "name" => "Nutella"
      }
    ],
    "kg" => "900kg",
    "name" => "Vulc??o Leite Ninho Com Nutella Bolo Ninho",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202103181801_IYIG_f.png"
      }
    ],
    "price" => "70.00"
  },
  %{
    "category" => "Bolos com Cobertura",
    "description" =>
      "Cont??m Gl??tem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em p?? integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "A????car"
      },
      %{
        "name" => "Leite Ninho em p??"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "??leo"
      },
      %{
        "name" => "Iorgute natural integral"
      },
      %{
        "name" => "fermento."
      }
    ],
    "kg" => "800kg",
    "name" => "Bolo Ninho com Cobertura",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_medium/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202106101216_12HS_i.jpg"
      }
    ],
    "price" => "40.00"
  },
  %{
    "category" => "Bolos Caseiros",
    "name" => "Bolo de milho cremoso",
    "kg" => "900kg",
    "ingredients" => [
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "A??ucar"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Milho"
      },
      %{
        "name" => "Milharina"
      },
      %{
        "name" => "??leo"
      },
      %{
        "name" => "coco ralado"
      },
      %{
        "name" => "queijo parmes??o"
      },
      %{
        "name" => "fermentos qu??micos."
      }
    ],
    "price" => "26.00",
    "description" =>
      "Cont??m Lactose. Al??rgicos: cont??m leite e derivados, derivados da soja, ovo e tra??os de trigo. N??o Cont??m Gl??ten*.*O bolo leva ingredientes selecionados e ?? produzido com o objetivo de n??o conter as indica????es acima, por??m, por ser produzido em ambientes que possuem, podem conter tra??os.",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102191606_twJv_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos Caseiros",
    "name" => "Bolo de fub??",
    "description" =>
      "Bolo quentinho ??timo para tomar com aquele caf??. Cont??m Gl??ten E Lactose. Al??rgicos: cont??m leite e derivados, derivados do trigo, derivados da soja e ovo",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171739_pmCp_f.png"
      }
    ],
    "ingredientes" => [
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "ac??car"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "??leo vegetal"
      },
      %{
        "name" => "fub??"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "queijo parmes??o"
      },
      %{
        "name" => "fermentos qu??micos pirofosfato de s??dio"
      },
      %{
        "name" => "bicarbonato de s??dio e fosfato monoc??lcico"
      }
    ],
    "kg" => "900g",
    "price" => "24.00"
  },
  %{
    "category" => "Bolos Caseiros",
    "name" => "Bolo de mandioca",
    "price" => "28.00",
    "kg" => "1050KG",
    "ingredients" => [
      %{
        "name" => "Mandioca"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "queijo parmes??o"
      },
      %{
        "name" => "coco ralado"
      },
      %{
        "name" => "leite integral"
      },
      %{
        "name" => "fermentos quimicos"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102201604_fE6M_f.png"
      }
    ],
    "description" =>
      "Cont??m Lactose. Al??rgicos: cont??m leite e derivados, ovo e tra??os de trigo. N??o Cont??m Gl??ten*"
  },
  %{
    "name" => "Fofinho Lim??o com Gotas de Chocolate",
    "category" => "Bolos Caseiros",
    "description" =>
      "Cont??m Gl??ten. Zero Lactose. Al??rgicos: cont??m derivados do trigo, derivados da soja e ovo. O bolo leva ingredientes selecionados e ?? produzido com o objetivo de n??o conter as indica????es acima, por??m, por ser produzido em ambientes que possuem, podem conter tra??os.",
    "price" => "28.00",
    "kg" => "1000KG",
    "ingredients" => [
      %{
        "name" => "Suco de lim??o"
      },
      %{
        "name" => "farinha de trigo"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "a????car refinado"
      },
      %{
        "name" => "??leo"
      },
      %{
        "name" => "fermentos qu??micos"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171844_7IPi_f.png"
      }
    ]
  },
  %{
    "name" => "Fuba com Goiabada",
    "category" => "Bolos Caseiros",
    "description" =>
      "Cont??m Gl??ten E Lactose. Al??rgicos: cont??m leite e derivados, derivados do trigo, derivados da soja e ovo.",
    "price" => "26.00",
    "kg" => "950g",
    "ingredients" => [
      %{
        "name" => "150 grs de goiabada dentro do bolo"
      },
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "??leo vegetal"
      },
      %{
        "name" => "goiabada"
      },
      %{
        "name" => "fub??"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "queijo parmes??o"
      },
      %{
        "name" => "fermentos qu??micos"
      },
      %{
        "name" => "pirofosfato de s??dio"
      },
      %{
        "name" => "bicarbonato de s??dio e fosfato monoc??lcico"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171748_7Tn9_f.png"
      }
    ]
  },
  %{
    "name" => "Bolo Fofinho de Chocolate",
    "category" => "Bolos Caseiros",
    "description" =>
      "Cont??m Gl??ten. Al??rgicos: cont??m derivados do leite, derivados do trigo, derivados da soja e ovo.",
    "price" => "24.00",
    "kg" => "800g",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "??leo vegetal"
      },
      %{
        "name" => "chocolate em p??"
      },
      %{
        "name" => "fermentos qu??micos"
      },
      %{
        "name" => "bicarbonato de s??dio"
      },
      %{
        "name" => "pirofosfato de s??dio e fosfato monoc??lcico"
      },
      %{
        "name" => "amido de milho"
      },
      %{
        "name" => "e sal"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171843_zA5f_f.png"
      }
    ]
  },
  %{
    "name" => "Cenoura com Gotas de Chocolate",
    "category" => "Bolos Caseiros",
    "description" =>
      "Cont??m Gl??ten E Lactose. Al??rgicos: cont??m derivados do leite, derivados do trigo, derivados da soja e ovo",
    "price" => "28.00",
    "kg" => "800g",
    "ingredients" => [
      %{
        "name" => "Cenouras"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "??leo vegetal"
      },
      %{
        "name" => "gotas de chocolate"
      },
      %{
        "name" => "fermentos qu??micos"
      },
      %{
        "name" => "pirofosfato de s??dio"
      },
      %{
        "name" => "bicarbonato de s??dio"
      },
      %{
        "name" => "e fosfato monoc??lcico"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102171824_Mn6Y_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos no pote",
    "name" => "Leite Ninho com Morango (pote)",
    "description" => "Bolo no pote ??timo para comer como sobremesa.",
    "price" => "14.00",
    "kg" => "300g",
    "ingredients" => [
      %{
        "name" => "a??ucar"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "morangos"
      },
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "Leite ninho"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102191158_oQPq_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos no pote",
    "name" => "Ninho com Nutella (pote)",
    "description" => "Bolo no pote ??timo para comer como sobremesa.",
    "price" => "14.00",
    "kg" => "300g",
    "ingredients" => [
      %{
        "name" => "a??ucar"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "Nutella"
      },
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "Leite ninho"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102191643_YclZ_f.png"
      }
    ]
  },
  %{
    "category" => "Coberturas",
    "name" => "Cobertura Goiabada derretida",
    "description" => "Cobertura feita com: Goiabada derretida",
    "price" => "14.00",
    "kg" => "300g",
    "ingredients" => [
      %{
        "name" => "Goiaba"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202101211112_4dGn_.jpeg"
      }
    ]
  },
  %{
    "category" => "Bolos Recheados",
    "name" => "Bolo Prest??gio com Recheio",
    "description" =>
      "Bolo fofinho de chocolate recheado com Prest??gio, coberto com ganache de chocolate ao leite e raspas de chocolate branco.",
    "price" => "55.00",
    "kg" => "1.150KG",
    "ingredients" => [
      %{
        "name" => "Chocolates"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "??leo vegetal"
      },
      %{
        "name" => "Ganache"
      },
      %{
        "name" => "Raspas de chocolate branco"
      },
      %{
        "name" => "Coco"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202105221801_6BB4_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos Recheados",
    "name" => "Bolo vulc??o de brigadeiro com morangos",
    "description" =>
      "Cont??m Gl??ten, E Lactose. Al??rgicos: cont??m derivados do leite, derivados do trigo, derivados da soja e ovo. Cobertura feita com leite condensado, creme de leite, margarina com sal e chocolate 32%. Recheado com morangos no miolo do bolo.",
    "price" => "60.00",
    "kg" => "1000KG",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo enriquecida com ferro e ??cido f??lico"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "??leo vegeta"
      },
      %{
        "name" => "chocolate em p??"
      },
      %{
        "name" => "fermentos qu??micos bicarbonato de s??dio"
      },
      %{
        "name" => "pirofosfato de s??dio"
      },
      %{
        "name" => "amido de milho e sal"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102181932_10uE_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos Recheados",
    "name" => "Novo - Vulc??o Prest??gio",
    "description" =>
      "Cont??m Gl??ten E Lactose. Al??rgicos: cont??m leite e derivados, derivados do trigo, coco e ovo.",
    "price" => "58,00",
    "kg" => "1300g",
    "ingredients" => [
      %{
        "name" => "Chocolates"
      },
      %{
        "name" => "recheio de prestigio"
      },
      %{
        "name" => "coberto com ganache"
      },
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "farinha de trigo"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "chocolate em p??"
      },
      %{
        "name" => "fermento"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202107271017_TOEI_i.jpg"
      }
    ]
  },
  %{
    "category" => "Bolos Recheados",
    "name" => "Vulc??o Nutella Bolo Cenoura com Gotas de Chocolate",
    "description" => "bem fofinho com o miolo recheado com 600 grs de Nutella.",
    "price" => "80,00",
    "kg" => "1000KG",
    "ingredients" => [
      %{
        "name" => "Gotas de chocolate"
      },
      %{
        "name" => "Nutella"
      },
      %{
        "name" => "Cenoutras"
      },
      %{
        "name" => "Leite integral"
      },
      %{
        "name" => "farinha de trigo"
      },
      %{
        "name" => "a????car"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "fermento"
      }
    ],
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102181942_CwSv_f.png"
      }
    ]
  }
]

cakes_params
|> Enum.map(fn cake_params ->
  SaborBrasileiro.create_cake(cake_params)
end)
