# lib/tasks/auto_annotate_models.rake

if Rails.env.development?
  # This hook is causing issues with newer Rails versions. Let's simplify.
  # We will run annotate manually or via a different hook if needed.
end