/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> {{.Provider.version}}"
    }
  }
}

provider "google" {
  {{if .Provider.credentials }}credentials = "{{.Provider.credentials}}"{{end}}
}

resource "google_project" "my_project-in-a-folder" {
  name = "My Project"
  project_id = "${random_string.suffix.result}"
  folder_id  = google_folder.department1.name

  billing_account = "{{.Project.BillingAccountName}}"

  labels  = {
    "project-label-key-a" = "project-label-val-a"
  }
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "google_folder" "department1" {
  display_name = "Department 1"
  parent     = "organizations/1234567"
}
