// @ts-check

/**
 * Implement the classes etc. that are needed to solve the
 * exercise in this file. Do not forget to export the entities
 * you defined so they are available for the tests.
 */

export function Size(width, height) {
  this.width = width == undefined ? 80 : width;
  this.height = height == undefined ? 60 : height;
}

Size.prototype.resize = function(newWidth, newHeight) {
  this.width = newWidth;
  this.height = newHeight;
}

export function Position(x, y) {
  this.x = x == undefined ? 0 : x;
  this.y = y == undefined ? 0 : y;
}

Position.prototype.move = function(newX, newY) {
  this.x = newX;
  this.y = newY;
}

export class ProgramWindow {
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }

  resize(newSize) {
    this.size = newSize;
    
    if (this.size.width < 1)
      this.size.width = 1;
    if (this.size.height < 1)
      this.size.height = 1;

    if (this.size.width + this.position.x > this.screenSize.width) 
      this.size.width = this.screenSize.width - this.position.x;
    if (this.size.height + this.position.y > this.screenSize.height)
      this.size.height = this.screenSize.height - this.position.y;
  }

  move(newPosition) {
    this.position = newPosition;

    if (this.position.x < 0)
      this.position.x = 0;
    if (this.position.y < 0)
      this.position.y = 0;

    if (this.size.width + this.position.x > this.screenSize.width) 
      this.position.x = this.screenSize.width - this.size.width;
    if (this.size.height + this.position.y > this.screenSize.height)
      this.position.y = this.screenSize.height - this.size.height;
  }
}

export const changeWindow = (programWindow) => {
    programWindow.size = new Size(400, 300);
    programWindow.position = new Position(100, 150);
    return programWindow;
}