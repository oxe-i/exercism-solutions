// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Removes duplicate tracks from a playlist.
 *
 * @param {string[]} playlist
 * @returns {string[]} new playlist with unique entries
 */

export function removeDuplicates(playlist) {
  const set = new Set();
  playlist.forEach((track) => set.add(track));
  const newPlaylist = [];
  set.forEach((entry) => newPlaylist.push(entry));
  return newPlaylist;
}

/**
 * Checks whether a playlist includes a track.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {boolean} whether the track is in the playlist
 */
export function hasTrack(playlist, track) {
  const set = new Set();
  playlist.forEach((track) => set.add(track));
  return set.has(track);
}

/**
 * Adds a track to a playlist.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function addTrack(playlist, track) {
  const set = new Set();
  playlist.forEach((track) => set.add(track));
  set.add(track);
  const newPlaylist = [];
  set.forEach((entry) => newPlaylist.push(entry));
  return newPlaylist;
}

/**
 * Deletes a track from a playlist.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function deleteTrack(playlist, track) {
  const set = new Set();
  playlist.forEach((track) => set.add(track));
  set.delete(track);
  const newPlaylist = [];
  set.forEach((entry) => newPlaylist.push(entry));
  return newPlaylist;
}

/**
 * Lists the unique artists in a playlist.
 *
 * @param {string[]} playlist
 * @returns {string[]} list of artists
 */
export function listArtists(playlist) {
  const set = new Set();
  playlist.forEach((track) => set.add(track.slice(track.indexOf('-') + 2)));
  const newPlaylist = [];
  set.forEach((entry) => newPlaylist.push(entry));
  return newPlaylist;
}
