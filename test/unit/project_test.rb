require File.expand_path('../../test_helper', __FILE__)

class ProjectTest < ActiveSupport::TestCase

  test "Our data is valid" do
    project = create_project
    assert project.valid?
    assert !project.new_record?
  end

  test "Tag a project with a tag twice should create a tag and update the counter to 2" do
    project = create_project
    project.tags = 'tag1'
    project.save
    assert_equal 1, project.tags.size

    tag = Tag.last
    assert_equal 'tag1', tag.name
    assert_equal 1, tag.count
    assert_equal 1, project.tags.size

    project.tags = 'tag1'
    tag.reload
    assert_equal 1, tag.count
    assert_equal 1, project.tags.size

    project2 = create_project :name => "Another project"
    project2.tags = 'tag1'
    project2.save
    tag.reload
    assert_equal 1, project2.tags.size

    assert_equal 2, tag.count

    tag.reload
    assert_equal 2, tag.projects.size
  end

  test "Tag a project with multiple tags" do
    project = create_project
    project.tags = 'tag1, tag2'
    assert_equal 2, project.tags.count

    tag1 = Tag.find_by_name('tag1')
    assert_equal 1, tag1.count

    tag2 = Tag.find_by_name('tag2')
    assert_equal 1, tag2.count

    project.tags = 'tag2, tag3'
    project.reload
    assert_equal 2, project.tags.count

    tag1 = Tag.find_by_name('tag1')
    assert_equal 0, tag1.count

    tag2 = Tag.find_by_name('tag2')
    assert_equal 1, tag2.count

    tag3 = Tag.find_by_name('tag3')
    assert_equal 1, tag3.count
  end

  test "Dates consistency" do
    project = new_project
    project.end_date = project.start_date - 5.days
    project.save
    assert !project.valid?
    assert project.errors[:end_date]
  end

end
