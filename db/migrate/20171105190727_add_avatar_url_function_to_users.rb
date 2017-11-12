class AddAvatarUrlFunctionToUsers < ActiveRecord::Migration[5.1]
  def up
    query = <<HERE
      CREATE FUNCTION get_users_avatar_url(user_id BIGINT, style TEXT, file_name TEXT)
        RETURNS CHARACTER VARYING
      LANGUAGE plpgsql
      AS $$
      BEGIN
        RETURN '/system/users/avatars/' || user_id :: TEXT || '/' || style || '/' ||
               get_file_name_without_extension(file_name);
      END;
      $$;
HERE

    execute query
  end

  def down
    execute 'DROP FUNCTION get_users_avatar_url(INTEGER, TEXT, TEXT);'
  end
end
