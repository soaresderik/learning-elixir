alias Rumbl.Repo
alias Rumbl.Category

for category <- ~w(Action Drama Romance Comedy Sci-fi Other) do
  Repo.get_by(Category, name: category) || Repo.insert(%Category{name: category})
end
