class SeriesErrors {
  static VALID = 0;
  static SLICE_NULL = "slice length cannot be zero";
  static SLICE_NEGATIVE = "slice length cannot be negative";
  static SLICE_GREATER_THAN_LENGTH = "slice length cannot be greater than series length";
  static SERIES_EMPTY = "series cannot be empty";
}

export class Series {
  constructor(seriesString) { 
    const error = this._checkSeries(seriesString);
    if (error) throw new Error(error);
    this.seriesArray = seriesString.split("").map(Number); 
  }

  _checkSeries(seriesString) {
    if (!seriesString.length) return SeriesErrors.SERIES_EMPTY;
    return SeriesErrors.VALID;
  }

  _checkSlice(sliceLength, maxLength) {
    if (sliceLength == 0) return SeriesErrors.SLICE_NULL;
    if (sliceLength < 0) return SeriesErrors.SLICE_NEGATIVE;
    if (sliceLength > maxLength) return SeriesErrors.SLICE_GREATER_THAN_LENGTH;
    return SeriesErrors.VALID;
  }

  slices(sliceLength) {
    const maxLength = this.seriesArray.length;
    const error = this._checkSlice(sliceLength, maxLength);
    
    if (error) throw new Error(error);
    
    return this.seriesArray.reduce((acc, _, crtIndex) => {
      const endIndex = crtIndex + sliceLength;
      if (endIndex <= maxLength) acc.push(this.seriesArray.slice(crtIndex, endIndex));
      return acc;
    }, []);
  }
}
