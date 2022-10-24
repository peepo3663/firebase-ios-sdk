#!/usr/bin/env bash
#
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DOCC_DERIVED_DATA=".build/"

if [[ -z "$GITHUB_ACTIONS" ]]; then
    echo "ignoring GoogleAppMeasurement version requirements"
    exit 1
    sed -i '' 's#exact("[0-9.]*#branch("main#' Package.swift
fi

if [[ -d "${DOCC_DERIVED_DATA}" ]]; then
    rm -rf "${DOCC_DERIVED_DATA}";
fi

mkdir "${DOCC_DERIVED_DATA}";

xcodebuild docbuild -scheme $1 \
    -derivedDataPath "${DOCC_DERIVED_DATA}" \
    -destination "generic/platform=iOS" \
    DOCC_HOSTING_BASE_PATH=""
