defmodule Searchex.Config.Helpers do

  @moduledoc false

  def name_from_path(path) do
    full_path = Path.expand(path)
    _cfg_name  = String.split(full_path, "/") |> List.last
  end

  def active_dirs do
    Searchex.settings
  end

  def cfg_file(cfg_name) do
    active_dirs.cfgs <> "/" <> cfg_name <> ".yml"
  end

  def cat_file(cfg_name) do
    active_dirs.data <> "/" <> cfg_name <> "_cat.yml"
  end

  def idx_file(cfg_name) do
    active_dirs.data <> "/" <> cfg_name <> "_idx.yml"
  end

  def make_active_dirs() do
    System.cmd("mkdir", ["-p"] ++ Map.values(active_dirs))
  end

  # -----

  def cfg_dir_missing_msg(path), do:
  "Path does not exist (#{path})"

  def cfg_exists_msg(cfg_name), do:
  "Config already exists (#{cfg_name})"

  def cfg_missing_msg(cfg_name), do:
  "Config not found (#{cfg_name})"

  def cfg_name_invalid_msg(cfg_name), do:
  "Invalid config name (#{cfg_name})"

  # -----

  def cfg

  def cfg_dir_exists?(path)      , do: File.dir?(path)

  def cfg_dir_absent?(path)      , do: ! cfg_dir_exists?(path)

  def cfg_name_valid?(cfg_name)  , do: ! Regex.match?(~r/[^0-9A-Za-z-_]/, cfg_name)

  def cfg_name_invalid?(cfg_name), do: ! cfg_name_valid?(cfg_name)

  def cfg_exists?(cfg_name)      , do: File.exists?(cfg_file(cfg_name))

  def cfg_missing?(cfg_name)     , do: ! cfg_exists?(cfg_name)

end
