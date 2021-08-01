require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject {
    Movie.new(title: "Downward Dog",
              poster: "https://m.media-amazon.com/images/M/MV5BODllOTA0MjktMGMzMi00NDQ5LWJhODMtZDg5ZmY3Y2FmNGMxXkEyXkFqcGdeQXVyNjEwNTM2Mzc@._V1_SX300.jpg",
              plot: "A lonely dog navigates the complexity of 21st century relationships.",
              runtime: "21 min",
              rated: "TV-PG",
              year: "2017",
              imdbID: "tt3879306")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with empty title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is valid with empty poster" do
    subject.poster = nil
    expect(subject).to be_valid
  end

  it "is valid with empty plot" do
    subject.plot = nil
    expect(subject).to be_valid
  end

  it "is valid with empty runtime" do
    subject.runtime = nil
    expect(subject).to be_valid
  end

  it "is valid with empty rating" do
    subject.rated = nil
    expect(subject).to be_valid
  end

  it "is valid with empty year" do
    subject.year = nil
    expect(subject).to be_valid
  end

  it "is valid with empty id" do
    subject.imdbID = nil
    expect(subject).to be_valid
  end

  it "is not valid without a description"
  it "is not valid without a start_date"
  it "is not valid without a end_date"
end
