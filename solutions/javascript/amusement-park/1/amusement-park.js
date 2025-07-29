/// <reference path="./global.d.ts" />
// @ts-check

/**
 * Creates a new visitor.
 *
 * @param {string} name
 * @param {number} age
 * @param {string} ticketId
 * @returns {Visitor} the visitor that was created
 */
export const createVisitor = (name, age, ticketId) => {
  const Visitor = {name: name, age: age, ticketId : ticketId};
  return Visitor;
}

/**
 * Revokes a ticket for a visitor.
 *
 * @param {Visitor} visitor the visitor with an active ticket
 * @returns {Visitor} the visitor without a ticket
 */
export const revokeTicket = (visitor) => {
  visitor.ticketId = null;
  return visitor;
}

/**
 * Determines the status a ticket has in the ticket tracking object.
 *
 * @param {Record<string, string|null>} tickets
 * @param {string} ticketId
 * @returns {string} ticket status
 */
export const ticketStatus = (tickets, ticketId) => {
  if (tickets[ticketId] === null) {
    return 'not sold';
  }
  else if (tickets[ticketId] === undefined) {
    return 'unknown ticket id';
  }
    return `sold to ${tickets[ticketId]}`; 
}
/**
 * Determines the status a ticket has in the ticket tracking object
 * and returns a simplified status message.
 *
 * @param {Record<string, string|null>} tickets
 * @param {string} ticketId
 * @returns {string} ticket status
 */
export function simpleTicketStatus(tickets, ticketId) {
  if (tickets[ticketId] === null || tickets[ticketId] === undefined) {
    return 'invalid ticket !!!';
  }

  return tickets[ticketId];
}

/**
 * Determines the version of the GTC that was signed by the visitor.
 *
 * @param {VisitorWithGtc} visitor
 * @returns {string | undefined} version
 */
export function gtcVersion(visitor) {
  return visitor.gtc === undefined ? undefined :
    visitor.gtc.version;
}
