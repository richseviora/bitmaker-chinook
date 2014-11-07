class QueriesController < ApplicationController
  def index
    # Cannot refer to related object directly, must first join it and then enter where statement.
    @hiphoptracks = Track.joins(:genre).where('genres.name = ?','Hip Hop/Rap')
    # Most use first because the returned object otherwise is the Active Record Relation array.
    @most_expensive_mpeg = Track.joins(:media_type).where('media_types.name = ?','MPEG audio file').order(unit_price: :desc).first

    @two_oldest_artists = Artist.order(created_at: :desc).limit(2)
    # Gets the first two playlists.
    @two_newest_playlists = Playlist.order(created_at: :desc).limit(2)

    # Gets the tracks for the first two playlists.
    # When operating with a HaBtM association, it is necessary to qualify the where statement with a hash otherwise it will query on the base record directly.
    @two_newest_playlist_tracks = Track.joins(:playlists).where(playlists: {:id => Playlist.order(created_at: :desc).limit(2)})

  end
end
