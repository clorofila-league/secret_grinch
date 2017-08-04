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
alias SecretGrinch.Matches.Match
alias SecretGrinch.User
alias SecretGrinch.Assignment
alias SecretGrinch.Message

Repo.delete_all Message
Repo.delete_all Assignment
Repo.delete_all Match
Repo.delete_all User

hulk = Repo.insert!(%User{
  email:    "hulk.clorofila@gmail.com",
  password: "green",
  name:     "Bruce Bane"
})

yoda = Repo.insert!(%User{
  email:    "yoda.clorofila@gmail.com",
  password: "green",
  name:     "Master Yoda"
})

goblin = Repo.insert!(%User{
  email:    "goblin.clorofila@gmail.com",
  password: "green",
  name:     "Norman Osborn"
})

not_started = Repo.insert!(%Match{
  name:         "Not Started Yet",
  start_date:   ~N[2017-08-05 00:00:00],
  end_date:     ~N[2017-09-05 00:00:00],
  organizer_id: hulk.id,
  users:        [hulk]
})

ongoing = Repo.insert!(%Match{
  name:         "Ongoing",
  start_date:   ~N[2017-08-03 00:00:00],
  end_date:     ~N[2017-09-03 00:00:00],
  organizer_id: hulk.id,
  users:        [hulk, yoda, goblin]
})

finished = Repo.insert!(%Match{
  name:         "Finished",
  start_date:   ~N[2017-07-01 00:00:00],
  end_date:     ~N[2017-08-01 00:00:00],
  organizer_id: hulk.id
})

Repo.insert!(%Assignment{
  match_id:     ongoing.id,
  sender_id:    hulk.id,
  recepient_id: yoda.id
})

Repo.insert!(%Assignment{
  match_id:     ongoing.id,
  sender_id:    yoda.id,
  recepient_id: goblin.id
})

Repo.insert!(%Assignment{
  match_id:     ongoing.id,
  sender_id:    goblin.id,
  recepient_id: hulk.id
})
