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
      "Contém Glútem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em pó integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "óleo"
      },
      %{
        "name" => "Iorgute natural integral"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em pó"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Açúcar"
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
      "Contém Glútem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em pó integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em pó"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Açúcar"
      },
      %{
        "name" => "Muita Ganache"
      },
      %{
        "name" => "fermento."
      },
      %{
        "name" => "óleo"
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
      "Contém Glútem e lactose, Bolo Ninho coberto com brigadeiro ótimo para sobremesa, feito com chocolate 32%, leite condensado, margarina e creme de leite.",
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
        "name" => "Açúcar"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em pó"
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
      "Bolo leite ninho ótimo para comer como sobremesa, Cobertura leite Ninho, com miolo recheado com Nutella e morangos. Cobertura feita com leite Ninho integral em pó, creme de leite, margarina sem sal e leite condensado.",
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
        "name" => "Açúcar"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em pó"
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
    "name" => "Vulcão Leite Ninho com Abacaxi",
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
      "Bolo leite ninho ótimo para comer como sobremesa, Recheio de Ovomaltine, coberto com leite Ninho Contem Leite integral, farinha de trigo enriquecida com ferro e ácido fólico, açúcar, ovo, chocolate em pó, fermentos químicos pirofosfato de sódio, bicarbonato de sódio e fosfato. Contém Glúten E Lactose.",
    "ingredients" => [
      %{
        "name" => "fermento."
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "Leite Ninho em pó"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Açúcar"
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
        "name" => "chocolate em pó"
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
    "name" => "Vulcão De Ovomaltine Coberto Com Ninho",
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
      "Bolo leite ninho ótimo para comer como sobremesa, Cobertura leite Ninho, com miolo recheado com Nutella. Cobertura feita com leite Ninho integral, creme de leite, margarina sem sal e leite condensado.",
    "ingredients" => [
      %{
        "name" => "gordura vegetal"
      },
      %{
        "name" => "Açúcar"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Leite Ninho em pó"
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
        "name" => "chocolate em pó"
      },
      %{
        "name" => "Nutella"
      }
    ],
    "kg" => "900kg",
    "name" => "Vulcão Leite Ninho Com Nutella Bolo Ninho",
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
      "Contém Glútem e lactose, Cobertura de leite Ninho feito com leite condensado, Ninho em pó integral, manteiga e creme de leite.",
    "ingredients" => [
      %{
        "name" => "Açúcar"
      },
      %{
        "name" => "Leite Ninho em pó"
      },
      %{
        "name" => "Ovos"
      },
      %{
        "name" => "Farinha de trigo"
      },
      %{
        "name" => "óleo"
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
        "name" => "Açucar"
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
        "name" => "óleo"
      },
      %{
        "name" => "coco ralado"
      },
      %{
        "name" => "queijo parmesão"
      },
      %{
        "name" => "fermentos químicos."
      }
    ],
    "price" => "26.00",
    "description" =>
      "Contém Lactose. Alérgicos: contém leite e derivados, derivados da soja, ovo e traços de trigo. Não Contém Glúten*.*O bolo leva ingredientes selecionados e é produzido com o objetivo de não conter as indicações acima, porém, por ser produzido em ambientes que possuem, podem conter traços.",
    "photos" => [
      %{
        "url" =>
          "https://static-images.ifood.com.br/image/upload/t_high/pratos/90d4317b-69e8-4b7e-9f7a-dd4d6deeb6f8/202102191606_twJv_f.png"
      }
    ]
  },
  %{
    "category" => "Bolos Caseiros",
    "name" => "Bolo de fubá",
    "description" =>
      "Bolo quentinho ótimo para tomar com aquele café. Contém Glúten E Lactose. Alérgicos: contém leite e derivados, derivados do trigo, derivados da soja e ovo",
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
        "name" => "acúcar"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "óleo vegetal"
      },
      %{
        "name" => "fubá"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "queijo parmesão"
      },
      %{
        "name" => "fermentos químicos pirofosfato de sódio"
      },
      %{
        "name" => "bicarbonato de sódio e fosfato monocálcico"
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
        "name" => "açúcar"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "queijo parmesão"
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
      "Contém Lactose. Alérgicos: contém leite e derivados, ovo e traços de trigo. Não Contém Glúten*"
  },
  %{
    "name" => "Fofinho Limão com Gotas de Chocolate",
    "category" => "Bolos Caseiros",
    "description" =>
      "Contém Glúten. Zero Lactose. Alérgicos: contém derivados do trigo, derivados da soja e ovo. O bolo leva ingredientes selecionados e é produzido com o objetivo de não conter as indicações acima, porém, por ser produzido em ambientes que possuem, podem conter traços.",
    "price" => "28.00",
    "kg" => "1000KG",
    "ingredients" => [
      %{
        "name" => "Suco de limão"
      },
      %{
        "name" => "farinha de trigo"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "açúcar refinado"
      },
      %{
        "name" => "óleo"
      },
      %{
        "name" => "fermentos químicos"
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
      "Contém Glúten E Lactose. Alérgicos: contém leite e derivados, derivados do trigo, derivados da soja e ovo.",
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
        "name" => "açúcar"
      },
      %{
        "name" => "ovo"
      },
      %{
        "name" => "óleo vegetal"
      },
      %{
        "name" => "goiabada"
      },
      %{
        "name" => "fubá"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "queijo parmesão"
      },
      %{
        "name" => "fermentos químicos"
      },
      %{
        "name" => "pirofosfato de sódio"
      },
      %{
        "name" => "bicarbonato de sódio e fosfato monocálcico"
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
      "Contém Glúten. Alérgicos: contém derivados do leite, derivados do trigo, derivados da soja e ovo.",
    "price" => "24.00",
    "kg" => "800g",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "açúcar"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "óleo vegetal"
      },
      %{
        "name" => "chocolate em pó"
      },
      %{
        "name" => "fermentos químicos"
      },
      %{
        "name" => "bicarbonato de sódio"
      },
      %{
        "name" => "pirofosfato de sódio e fosfato monocálcico"
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
      "Contém Glúten E Lactose. Alérgicos: contém derivados do leite, derivados do trigo, derivados da soja e ovo",
    "price" => "28.00",
    "kg" => "800g",
    "ingredients" => [
      %{
        "name" => "Cenouras"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "açúcar"
      },
      %{
        "name" => "óleo vegetal"
      },
      %{
        "name" => "gotas de chocolate"
      },
      %{
        "name" => "fermentos químicos"
      },
      %{
        "name" => "pirofosfato de sódio"
      },
      %{
        "name" => "bicarbonato de sódio"
      },
      %{
        "name" => "e fosfato monocálcico"
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
    "description" => "Bolo no pote ótimo para comer como sobremesa.",
    "price" => "14.00",
    "kg" => "300g",
    "ingredients" => [
      %{
        "name" => "açucar"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
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
    "description" => "Bolo no pote ótimo para comer como sobremesa.",
    "price" => "14.00",
    "kg" => "300g",
    "ingredients" => [
      %{
        "name" => "açucar"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
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
    "name" => "Bolo Prestígio com Recheio",
    "description" =>
      "Bolo fofinho de chocolate recheado com Prestígio, coberto com ganache de chocolate ao leite e raspas de chocolate branco.",
    "price" => "55.00",
    "kg" => "1.150KG",
    "ingredients" => [
      %{
        "name" => "Chocolates"
      },
      %{
        "name" => "farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "açúcar"
      },
      %{
        "name" => "óleo vegetal"
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
    "name" => "Bolo vulcão de brigadeiro com morangos",
    "description" =>
      "Contém Glúten, E Lactose. Alérgicos: contém derivados do leite, derivados do trigo, derivados da soja e ovo. Cobertura feita com leite condensado, creme de leite, margarina com sal e chocolate 32%. Recheado com morangos no miolo do bolo.",
    "price" => "60.00",
    "kg" => "1000KG",
    "ingredients" => [
      %{
        "name" => "Farinha de trigo enriquecida com ferro e ácido fólico"
      },
      %{
        "name" => "açúcar"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "óleo vegeta"
      },
      %{
        "name" => "chocolate em pó"
      },
      %{
        "name" => "fermentos químicos bicarbonato de sódio"
      },
      %{
        "name" => "pirofosfato de sódio"
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
    "name" => "Novo - Vulcão Prestígio",
    "description" =>
      "Contém Glúten E Lactose. Alérgicos: contém leite e derivados, derivados do trigo, coco e ovo.",
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
        "name" => "açúcar"
      },
      %{
        "name" => "ovos"
      },
      %{
        "name" => "chocolate em pó"
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
    "name" => "Vulcão Nutella Bolo Cenoura com Gotas de Chocolate",
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
        "name" => "açúcar"
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
