provider "github" {
  version = "~> 2.2.1"
  base_url     = "https://github.com/api/v3/"
  organization = "< git-org-name >"
  token        = var.github_token
}