# Stardates

```
(@v1.6) pkg> add git@192.168.1.86:chrisoei/Stardates.jl.git
     Cloning git-repo `git@192.168.1.86:chrisoei/Stardates.jl.git`
SSH host verification: the identity of the server `192.168.1.86:22` does not match its known hosts record. Someone could be trying to man-in-the-middle your connection. It is also possible that the server has changed its key, in which case you should check with the server administrator and if they confirm that the key has been changed, update your known hosts file.
ERROR: failed to clone from git@192.168.1.86:chrisoei/Stardates.jl.git, error: GitError(Code:ERROR, Class:Net, user cancelled hostkey check)
```

Solution (as per https://stackoverflow.com/questions/13363553/git-error-host-key-verification-failed-when-connecting-to-remote-repository):
```
c@h269x:~$ ssh-keyscan 192.168.1.86 >> ~/.ssh/known_hosts
```

```
(@v1.6) pkg> add git@192.168.1.86:chrisoei/Stardates.jl.git
     Cloning git-repo `git@192.168.1.86:chrisoei/Stardates.jl.git`
    Updating git-repo `git@192.168.1.86:chrisoei/Stardates.jl.git`
    Updating registry at `~/.julia/registries/General`
   Resolving package versions...
    Updating `~/.julia/environments/v1.6/Project.toml`
  [509f810d] + Stardates v2.0.0 `git@192.168.1.86:chrisoei/Stardates.jl.git#master`
    Updating `~/.julia/environments/v1.6/Manifest.toml`
  [509f810d] + Stardates v2.0.0 `git@192.168.1.86:chrisoei/Stardates.jl.git#master`
Precompiling project...
  1 dependency successfully precompiled in 2 seconds (254 already precompiled)

julia> using Stardates

julia> Stardate()
Stardate(2021.800063863648, "2021.800063863647893", "2021.800")

julia> Stardate(year = 2010, month = 5, day = 6, hour = 14, minute = 45,
           tz = "America/New_York")
Stardate(2010.3446061643835, "2010.344606164383549", "2010.345")

julia> mstardate(".")
Stardate(2021.800059999239, "2021.800059999239011", "2021.800")

julia> nyse_closing_stardate("2010-05-06")
2010.3447488584475

```

