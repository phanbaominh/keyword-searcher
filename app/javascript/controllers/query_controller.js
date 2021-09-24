import { Controller } from '@hotwired/stimulus';
import Chart from 'chart.js/auto';
// let ei = 0;
// function randomElection(name = `Election_${ei}`) {
//   return { name, id: ei, date: `200${ei++}-01-01` };
// }
// let pi = 0;
// function randomP(name = `Party_${pi}`) {
//   return { name, id: pi++ };
// }
// let sp = randomP();
// function randomER() {
//   return {
//     votes: Math.round(Math.random() * 10),
//     election: randomElection(),
//     party: sp,
//   };
// }
// Connects to data-controller="query"
export default class extends Controller {
  static targets = ['result'];
  connect() {
    console.log('Hello!');
  }
  displayResult(event) {
    console.log('Display!', event.detail);
    const elections = new Map();
    const parties = new Map();
    const queryResult = event.detail[0];
    // const queryResult = [randomER(), randomER(), randomER()];
    queryResult.forEach((electionResult) => {
      const election = electionResult.election;
      const party = electionResult.party;
      if (elections.has(election.id)) {
        elections.get(election.id).results.push(electionResult);
      } else {
        elections.set(election.id, { ...election, results: [electionResult] });
      }
      if (parties.has(party.id)) {
        parties.get(party.id).results.push(electionResult);
      } else {
        parties.set(party.id, { ...party, results: [electionResult] });
      }
    });
    console.log(parties);
    this.#createElectionCharts(elections);
    this.#createPartyCharts(parties);
  }

  #createPartyCharts(parties) {
    parties.forEach((party) => {
      if (party.results.length > 1) {
        const canvas = $('<canvas></canvas>');
        const results = party.results;
        results.sort((a, b) => {
          new Date(a.date).valueOf() - new Date(b.date).valueOf();
        });
        $(this.resultTarget).append(canvas);
        const data = {
          labels: results.map((result) => result.election.name),
          datasets: [
            {
              label: `${party.name} result`,
              data: results.map((result) => result.votes),
              borderWidth: 1,
            },
          ],
        };

        this.#createChart(canvas, data, 'line');
      }
    });
  }
  #createElectionCharts(elections) {
    elections.forEach((election) => {
      if (election.results.length > 1) {
        const canvas = $('<canvas></canvas>');

        $(this.resultTarget).append(canvas);
        const data = {
          labels: election.results.map((result) => result.party.name),
          datasets: [
            {
              label: `${election.name} result`,
              data: election.results.map((result) => result.votes),
              borderWidth: 1,
            },
          ],
        };

        this.#createChart(canvas, data);
      }
    });
  }
  #createChart(canvas, data, type = 'bar') {
    new Chart(canvas, {
      type,
      data,
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    });
  }
}
