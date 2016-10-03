# github-labeller

Bash script for setting up labels on a Github repository.

This script came about because there is seemingly no way to customize the
default set of labels, and it doesn't line up well with our internal process
at Flippa.

## Usage

```
GH_USER=foo GH_TOKEN=bar GH_REPO=baz ./github-labeller.sh
```

In its default mode of operation, it will login using `GH_USER:GH_TOKEN` as
basic auth credentials and modify the repository at `GH_OWNER/GH_REPO`. It will
delete all the default labels, and then replace them with a new set.

If `GH_OWNER` is not specified directly, it will default to `GH_USER`.

## Customizing the labels

Just change the invocations of `gh_label_create` to specify the desired
label/colour combinations. Remove the `gh_label_delete` calls of any
default labels you'd like to keep.
