class AddGetFileNameWithoutExtensionFunction < ActiveRecord::Migration[5.1]
  def up
    query = <<HERE
      CREATE FUNCTION get_file_name_without_extension(file_name TEXT)
        RETURNS TEXT
      LANGUAGE plpgsql
      AS $$
      BEGIN
        RETURN substring(file_name FROM 1 FOR length(file_name) - strpos(reverse(file_name), '.'));
      END;
      $$;
HERE

    execute query
  end

  def down
    execute 'DROP FUNCTION get_file_name_without_extension(file_name TEXT);'
  end
end
