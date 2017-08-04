# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SecretGrinch.Repo.insert!(%SecretGrinch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SecretGrinch.Repo
alias SecretGrinch.Match
alias SecretGrinch.User

Repo.delete_all Match
Repo.delete_all User

persisted_user = Repo.insert!(%User{
  email:    "hulk.clorofila@gmail.com",
  password: "green",
  name:     "Bruce Bane"
})

Repo.insert!(%Match{
    name:         "Not Started Yet",
    start_date:   ~N[2017-08-05 00:00:00],
    end_date:     ~N[2017-09-05 00:00:00],
    organizer_id: persisted_user.id
  })

Repo.insert!(%Match{
    name:         "Ongoing",
    start_date:   ~N[2017-08-03 00:00:00],
    end_date:     ~N[2017-09-03 00:00:00],
    organizer_id: persisted_user.id
  })

Repo.insert!(%Match{
    name:         "Finished",
    start_date:   ~N[2017-07-01 00:00:00],
    end_date:     ~N[2017-08-01 00:00:00],
    organizer_id: persisted_user.id
  })
