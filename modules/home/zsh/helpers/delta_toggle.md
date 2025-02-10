# 🔄 How to Use It Properly

## 1️⃣ Running the script directly (no persistent change)

```sh
Copy
Edit
./delta-toggle.sh side-by-side
```

🚀 This will toggle the side-by-side feature but won’t update your environment.

## 2️⃣ Persisting the change in the environment

Since Bash scripts cannot modify parent shell variables, you must export the result manually:

```sh
export DELTA_FEATURES=$(./delta-toggle.sh side-by-side)
```

Or, use a shell function for convenience:

```sh
delta-toggle() {
    export DELTA_FEATURES=$(./delta-toggle.sh "$1")
}
```

Now, toggle features like this:

```sh
delta-toggle side
```

Then check:

```sh
echo $DELTA_FEATURES
```

delta-toggle # shows current features

delta-toggle s # toggles side-by-side

delta-toggle l # toggles line-numbers

export FORGIT_LOG_FZF_OPTS='
--bind="ctrl-e:execute(echo {} |grep -Eo [a-f0-9]+ |head -1 |xargs git show |vim -)"
--bind="ctrl-s:execute(delta-toggle s)"
'
