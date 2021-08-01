alias SaborBrasileiro.{Repo, User}
alias Ecto.Changeset

user_admin_params = %{
  "name" => "Crispim Borges",
  "surname" => "Lemos",
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
  }
]

cakes_params
|> Enum.map(fn cake_params ->
  SaborBrasileiro.create_cake(cake_params)
end)
