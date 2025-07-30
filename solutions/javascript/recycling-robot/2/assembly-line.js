import { ElectronicDevice } from './lib.js';

export function isBoolean(value) {
  return typeof value == "boolean";
}

export function isNumber(value) {
  return (typeof value == "number" && isFinite(value)) || typeof value == "bigint";
}

export function isObject(value) {
  return typeof value == "object" && value !== null;
}

export function isNumericString(value) {
  return typeof value == "string" && /^-?\d+$/.test(value);
}

export function isElectronic(object) {
  return object instanceof ElectronicDevice;
}

export function isNonEmptyArray(value) {
  return Array.isArray(value) && value.length != 0;
}

export function isEmptyArray(value) {
  return Array.isArray(value) && value.length == 0;
}

export function assertHasId(object) {
  if ("id" in object) return;
  throw new Error("id is not defined");
}

export function hasType(object) {
  return "type" in object;
}

export function hasIdProperty(object) {
  return Object.hasOwn(object, "id");
}

export function hasDefinedType(object) {
  return Object.hasOwn(object, "type") && object.type !== undefined;
}
